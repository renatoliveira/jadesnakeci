# -*- coding: utf-8 -*-
import threading
from Build import *
import time

# print('Name: ' + str(__name__))
class Scheduler:
    @staticmethod
    def updated_plan_list(db):
        return db.sc_get_plans()

    # check for build time for each second
    def __check_builds(self, db_handler):
        # current_time = time.gmtime()
        keep_checking = True
        while keep_checking:
            try:
                print('Begin Builds Check...')
                # for b in range(len(plans)):
                #     print(plans[b])

                print('Current number of builds in queue: ' + str(len(self.current_builds)))

                for build in self.current_builds:
                    if build.status == 'starting':
                        build.status = 'building'

                        self.db.add_build(
                            build.plan_id,      # plan id
                            build.build_no,     # number
                            'building',         # status
                            '',                 # log
                            '',                 # result
                            0,                  # error count
                            0,                  # time elapsed
                        )

                        print('Starting build')
                        build.start()
                    elif build.status == 'finished':
                        print('Build finished!')
                        self.db.set_finish_build(build.build_no, build.plan_id, build.elapsed_time)
                        self.current_builds.remove(build)

                # plans = self.updated_plan_list(db_handler)
                print('Finish Builds Check...')
                time.sleep(2)
            except Exception as e:
                raise e

        # time.struct_time(tm_year=2015, tm_mon=7, tm_mday=6, tm_hour=18,
        # tm_min=7, tm_sec=8, tm_wday=0, tm_yday=187, tm_isdst=0)
        # print(current_time.tm_mday)

    # start building the plan with the specified ID
    def start_build(self, plan_id):
        plan = self.db.get_plan(plan_id)
        # example:
        # (1, 1, 1, 'retrieve', 0, None, None, None, None, None)
        if plan[3] == 'retrieve':
            # do retrieve
            # TODO: setting the plan in the list as 'busy' or something
            print('Starting a retrieve build...')
            #self.db.set_build_status(id, 'building')
            self.current_builds.append(Build('retrieve', self.db, plan_id))

        elif plan[3] == 'deploy':
            # do deploy
            print('Starting a deployment build...')
            #self.db.set_build_status(id, 'building')
            self.current_builds.append(Build('deploy', self.db, plan_id))

    def __init__(self, db_handler):
        self.current_builds = list()
        self.ongoing_builds = list()
        self.db = db_handler
        # plans = self.db.sc_get_plans()
        print('Starting thread')
        t = threading.Thread(target=self.__check_builds, args=(self.db,))
        t.start()