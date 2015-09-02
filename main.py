# -*- coding: utf-8 -*-
from bottle import *
from DBOperations import *
import error
import threading
from Scheduler import *

# Bottle container and error handler (error.py is the router)
app = Bottle()
app.error_handler = error.handler

# a simple list to store system messages
system_messages = []
system_warnings = []
system_errors = []

# plans that are running
current_actions = []

# database class
db = DBOperations()

# scheduler
scheduler = Scheduler(db)

original_dir = os.getcwd()

# function to clear the system messages list
def clear_messages():
    system_messages.clear()
    system_warnings.clear()
    system_errors.clear()

def check_current_builds():
    if len(scheduler.current_builds) > 0:
        os.chdir(original_dir)

# JS Home
# need to show the projects and its plans
@app.route('/')
def index():
    check_current_builds()
    clear_messages()
    plans = db.query_plan_builds(1)
    # print(plans)
    # TODO: get project and plan informations
    # TODO: Display them on screen
    return template(
        'templates/index.tpl',
        messages=system_messages,
        warnings=system_warnings,
        errors=system_errors)

# static files
@app.route('/static/<filepath:path>')
def static_files(filepath):
    check_current_builds()
    return static_file(
        filepath,
        root='static')

@app.route('/plans')
def plans_page():
    check_current_builds()
    clear_messages()
    plans = db.get_plans()
    if not plans:
        system_messages.append('There are no plans registered.')

    return template(
        'templates/plans.tpl',
        plans=plans,
        db=db,
        messages=system_messages,
        warnings=system_warnings,
        errors=system_errors)

@app.route('/newplan')
def new_plan_page():
    check_current_builds()
    clear_messages()
    all_projects = db.get_projects()
    all_orgs = db.get_orgs()

    if all_projects is None:
        system_warnings.append('There are no projects registered.')
        system_warnings.append('You need to create at least one project to proceed.')
    if all_orgs is None:
        system_warnings.append('There are no orgs registered.')
        system_warnings.append('You need to register at least one org to proceed.')

    return template(
        'templates/plan_registration.tpl',
        projects=all_projects,
        orgs=all_orgs,
        messages=system_messages,
        warnings=system_warnings,
        errors=system_errors)

@app.route('/newplan', method='POST')
def new_plan_result():
    check_current_builds()
    all_projects = db.get_projects()
    all_orgs = db.get_orgs()

    plan_info = []
    plan_info.extend(
        (request.forms.get('projectid'),
         request.forms.get('orgid'),
         request.forms.get('type')))

    if None in plan_info or '' in plan_info:
        clear_messages()
        system_errors.append('Some plan information was either blank or incorrect.')
        return template(
            'templates/plan_registration.tpl',
            projects=all_projects,
            orgs=all_orgs,
            messages=system_messages,
            warnings=system_warnings,
            errors=system_errors)
    else:
        clear_messages()
        system_messages.append('New ' + str(plan_info[2]) + ' plan was added.')
        db.add_new_plan(plan_info[0], plan_info[2], plan_info[1])

    return template(
        'templates/plan_registration.tpl',
        projects=all_projects,
        orgs=all_orgs,
        messages=system_messages,
        warnings=system_warnings,
        errors=system_errors)

@app.route('/projects')
def projects_index():
    check_current_builds()
    clear_messages()
    all_projects = db.get_projects()
    all_plans = db.get_plans()

    if len(all_projects) == 0:
        system_messages.append('There is no project registered.')

    return template(
        'templates/project_index.tpl',
        plans=all_plans,
        projects=all_projects,
        messages=system_messages,
        warnings=system_warnings,
        errors=system_errors)

@app.route('/newproject')
def register_project():
    check_current_builds()
    return template(
        'templates/project_registration.tpl',
        messages=system_messages,
        warnings=system_warnings,
        errors=system_errors)


@app.route('/newproject', method='POST')
def register_project_post():
    check_current_builds()
    project_info = []
    project_info.extend((
        request.forms.get('project_name'),
        request.forms.get('project_acronym')))

    if None in project_info or '' in project_info:
        clear_messages()
        system_errors.append('Some information was not filled correctly. Please review them and submit them again.')
    else:
        clear_messages()
        db.add_new_project(project_info[0], project_info[1])
        system_messages.append('Added a new project with the name \'' + str(project_info[0]) + '\'')

    return template(
        'templates/project_registration.tpl',
        messages=system_messages,
        warnings=system_warnings,
        errors=system_errors)

@app.route('/e/project/<id>')
@app.route('/e/project/<id>', method='POST')
def edit_project(id):
    check_current_builds()
    clear_messages()
    print(request.method)

    project_name = request.forms.get('project_name')
    project_acronym = request.forms.get('project_acronym')
    project_status = request.forms.get('project_status')
    project_id = request.forms.get('project_id')

    if request.method == 'GET':

        try:
            project_info = db.get_project_info(id)
            project_plans = db.get_project_plans(id)
            project_latest_builds = db.get_latest_project_builds(id)

            if project_info is None:
                # system_errors.append('No project with this Id exists.')
                abort(904, 'No project with this Id exists.')

        except Exception as e:
            abort(904, 'No project with this Id exists.')

        return template(
            'templates/project_edit.tpl',
            project_info=project_info,
            messages=system_messages,
            warnings=system_warnings,
            errors=system_errors)

    else: # if post
        clear_messages()
        # print('olar')
        if project_id is not None and project_name is not None and project_acronym is not None and project_status is not None:
            try:
                print('caiu aqui')
                db.update_project(project_id, project_name, project_acronym, project_status)
                system_messages.append('Updated project successfully!')
                project_info = db.get_project_info(project_id)
            except Exception as e:
                system_errors.append(e)
                abort(905, 'Error updating the project.\n' + str(e))
        else:
            system_errors.append('Some information was not correct or incomplete.')
            project_info = db.get_project_info(project_id)

        return template(
            'templates/project_edit.tpl',
            project_info=project_info,
            messages=system_messages,
            warnings=system_warnings,
            errors=system_errors)

@app.route('/orgs')
def orgs_index():
    check_current_builds()
    clear_messages()
    all_orgs = db.get_orgs()

    if len(all_orgs) == 0:
        system_messages.append('There are no registered Salesforce orgs.')

    return template(
        'templates/orgs_index.tpl',
        orgs=all_orgs,
        messages=system_messages,
        warnings=system_warnings,
        errors=system_errors)

@app.route('/neworg')
def register_new_org():
    check_current_builds()
    all_projects = db.get_projects()
    return template(
        'templates/org_registration.tpl',
        projects=all_projects,
        messages=system_messages,
        warnings=system_warnings,
        errors=system_errors)

@app.route('/neworg', method='POST')
def register_new_org():
    check_current_builds()
    clear_messages()
    org_info = []
    org_info.extend(
        (request.forms.get('username'),
         request.forms.get('password'),
         request.forms.get('sectoken'),
         request.forms.get('projectid')))

    print('ProjectID: ' + str(org_info[3]))
    # check if some information is null
    if None in org_info or '' in org_info:
        system_errors.append('Some org information was incorrect. Please review your information and re-submit the form.')
        return template(
            'templates/org_registration.tpl',
            projects=[],
            messages=system_messages,
            warnings=system_warnings,
            errors=system_errors)

    # if the information apparently is correct, we proceed to add to the db
    else:
        db.add_new_org(org_info[0], org_info[1], org_info[2], org_info[3])

    return template(
        'templates/org_registration.tpl',
        projects=[],
        messages=system_messages,
        warnings=system_warnings,
        errors=system_errors)

@app.route('/e/org/<id>')
@app.route('/e/org/<id>', method='POST')
def edit_org(id):
    check_current_builds()
    if request.method == 'GET':
        clear_messages()
        org_info = db.get_org_info(id)
        print(org_info)
        if org_info is None:
            system_errors.append('No org with the specified Id was found.')
            return template(
                'templates/orgs_index.tpl',
                orgs=list(),
                messages=system_messages,
                warnings=system_warnings,
                errors=system_errors)
        else:
            print(org_info)
            return template(
                'templates/org_edit.tpl',
                org_info=org_info,
                messages=system_messages,
                warnings=system_warnings,
                errors=system_errors)
    else: # post
        clear_messages()
        org_info = list()
        org_info.append(request.forms.get('org_id'))
        org_info.append(request.forms.get('org_project_id'))
        org_info.append(request.forms.get('org_login'))
        org_info.append(request.forms.get('org_password'))
        org_info.append(request.forms.get('org_sectoken'))
        org_info.append(request.forms.get('org_description'))

        if None in org_info or '' in org_info:
            if org_info[5] is None:
                pass
            system_errors.append('Some information was not specified or was improperly specified.')
            # print(org_info)
            return template(
                    'templates/org_edit.tpl',
                    org_info=org_info,
                    messages=system_messages,
                    warnings=system_warnings,
                    errors=system_errors)
        else:
            try:
                db.update_org(org_info[0], org_info[2], org_info[3], org_info[4], org_info[5])
                system_messages.append('Org information updated successfully!')
                return template(
                    'templates/org_edit.tpl',
                    org_info=org_info,
                    messages=system_messages,
                    warnings=system_warnings,
                    errors=system_errors)
            except Exception as e:
                print(e)
                abort(905, 'Error updating the org information')

@app.route('/builds')
def build_index():
    check_current_builds()
    clear_messages()
    builds = scheduler.current_builds

    latest_completed_builds = db.get_latest_completed_builds()

    # assuring that the list is at least empty instead of null
    if latest_completed_builds is None:
        latest_completed_builds = list()

    return template(
        'templates/build_index.tpl',
        builds=builds,
        completed_builds=latest_completed_builds,
        db=db,
        messages=system_messages,
        warnings=system_warnings,
        errors=system_errors)\

# -------------
# plan controls (ajax in the future?)
@app.route('/run_plan/<id>')
def run_plan(id):
    check_current_builds()
    # run the plan with specified id
    # and return the corresponding status
    # print('Trying to run the plan with id = ' + str(id))
    scheduler.start_build(id) # passing the plan id
    # time.sleep(1)
    redirect('/builds')

@app.route('/pause_plan/<id>')
def pause_plan(id):
    check_current_builds()
    # pause the plan with specified id
    # and return the corresponding status
    print('Trying to pause the plan with id = ' + str(id))

# ! ajax specific !
@app.route('/checkplan/<plan_id>/<build_id>')
def check_plan_status(plan_id, build_id):
    check_current_builds()
    # check plan status and return it
    # and return the corresponding status
    if plan_id != 'None' and build_id != 'None':
        status = db.get_build_status(plan_id, build_id)
        # print('Checking status of plan with id = ' + str(plan_id) + ' and build with id = ' + str(build_id))

        # we return strings because ints are not supported
        if status == 'building':
            return '1'
        elif status == 'finished':
            return '0'
        else:
            return '-1'
    else:
        print('[Warning] Tried to get something with Id=None')
        return '-1'

# JUST RUN IT
run(app=app, host='localhost', port=3000, debug=True)