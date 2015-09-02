# this is an example of working ant operation
import subprocess
import re
import sys

def jadeprint(msg):
    print('[JadeSnake] ' + str(msg))

def deploy_org(build_id, db_handler):
    jadeprint('Calling \'ValidateOrg\'')
    result = subprocess.getoutput('ant ValidateOrg')

    jadeprint('Checking validation result...')

    # prints the result of the 'ValidateOrg' command
    jadeprint('\'ValidateOrg\' results:')
    jadeprint(result)

    if 'BUILD SUCCESSFUL' in result:
        jadeprint('Trying to get the 18-digit deployment code')

        # get the 18-digit code
        the_18_digit_code = re.search('\\b(\w|\d){18}\\b', result).group(0)

        jadeprint('Running the \'quickDeploy\' command...')
        jadeprint('ant quickDeploy -DrecentValidation=' + str(the_18_digit_code))

        # run the command
        quick_deploy = subprocess.getoutput('ant quickDeploy -DrecentValidation=' + the_18_digit_code)

        # prints the quickDeploy commands
        jadeprint('Quick deploy logs:')
        jadeprint(quick_deploy)
        # check wheter we succeeded or not
        if 'BUILD SUCCESSFUL' in quick_deploy:
            jadeprint('DEPLOYMENT STATUS: SUCCESS')
            jadeprint(quick_deploy)
            jadeprint('Exiting with code = 0')
            db_handler.set_build_result(build_id, result)
            return True
        else:
            jadeprint('DEPLOYMENT STATUS: FAILED')
            jadeprint(quick_deploy)
            jadeprint('Exiting with code = 1')
            db_handler.set_build_result(build_id, result)
            return False
    else:
        jadeprint('Build failed, exiting with code = 1')
        jadeprint('Output:')
        jadeprint(result)
        jadeprint('End')
        db_handler.set_build_result(build_id, result)
        return True

def retrieve_org(build_id, db_handler):
    jadeprint('Calling \'RetrieveOrg\'')
    result = subprocess.getoutput('ant RetrieveOrg')
    jadeprint('Checking retrieve result...')

    if 'BUILD SUCCESSFUL' in result:
        jadeprint('Retrieve was successful!')
        db_handler.set_build_result(build_id, result)
        return True
    else:
        db_handler.set_build_result(build_id, result)
        return False
