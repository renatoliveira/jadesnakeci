# -*- coding: utf-8 -*-
# class to actually run the things
import jadesnake
import os
import datetime
'''
Build status can be one of the following:
1. starting
2. building
3. finished
'''
class Build:
    def __finish_build(self):
        self.status = 'finished'
        self.end_time = datetime.datetime.now()
        self.elapsed_time = (self.end_time - self.start_time).seconds

    def start(self):
        self.build_id = self.db.get_build_id(self.plan_id)
        self.db.set_build_status(self.build_id, 'building')

        # check if project folder exists
        print('Build path: ' + str(os.getcwd()))
        print('Build type: ' + str(self.build_type).capitalize())
        print('Build nº: ' + str(self.build_no))

        original_dir = os.getcwd()
        project_dir = str(os.getcwd()) + '\\projects\\' + self.db.get_plan_acronym(self.plan_id)
        project_path = 'projects/' + self.db.get_plan_acronym(self.plan_id)

        # check if project_dir exists
        # /projects/<project_acronym>/
        # if it doesnt, create it
        print('Checking if directory exists: ' + project_dir)
        if not os.path.isdir(str(os.getcwd()) + '\\projects\\'):
            print('\'Project\' directory does not exist. Creating it now...')
            os.mkdir('projects')
            print('\'Project\' directory created.')

        if os.path.isdir(project_dir):
            print('Directory EXISTS!!')
        else:
            print('Directory DOES NOT EXISTS!')
            os.mkdir(project_path)
            print('Directory created!')

        # start the build
        os.chdir(project_dir)
        print('Current project_dir: ' + os.getcwd())

        if self.build_type == 'retrieve':
            if jadesnake.retrieve_org(self.build_id, self.db):
                print('YAY THE RETRIEVE WORKED!')
                self.__finish_build()
            else:
                print('Aw, the retrieve didn\'t work.')
                self.__finish_build()

        elif self.build_type == 'deploy':
            if jadesnake.deploy_org(self.build_id, self.db):
                print('THE DEPLOY WORKED! :D')
                self.__finish_build()
            else:
                print('Aw, the deploy didn\'t work...')
                self.__finish_build()

        # remember to change to the original project_dir, so Bottle still works
        os.chdir(original_dir)
        # print('Current project_dir: ' + os.getcwd())

    def __init__(self, build_type, db_handler, plan_id):
        # initialize the build class passing the following arguments:
        # int, int, int, int, text
        # Number, ProjectId, OrgId, PlanId, Status
        # and finally, filling the following fields:
        # text, int, int, int
        # BuildLog, BuildResult, ErrorCount, TimeElapsed
        print('[BUILD] Starting new build!')
        # build ID is retrieved in the 'start' function
        self.build_id = None
        self.start_time = datetime.datetime.now()
        self.end_time = 0
        self.elapsed_time = -1
        self.average_build_time = db_handler.get_average_build_time_by_plan(plan_id)
        self.plan_acronym = db_handler.get_plan_acronym(plan_id)
        self.plan_id = plan_id
        self.build_type = build_type
        self.db = db_handler
        self.build_no = db_handler.generate_build_number(plan_id)
        self.status = 'starting'
