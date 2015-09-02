# -*- coding: utf-8 -*-
import sqlite3

database_name = 'database.db'

class DBOperations:
    def __init__(self):
        need_init = False
        from os.path import isfile, getsize
        from os import getcwd

        if not isfile(getcwd() + '/' + database_name) or getsize(getcwd() + '/' + database_name) < 100:
            need_init =True

        self.con = sqlite3.connect(database_name, check_same_thread=False)

        if need_init:
            self.init(self.con)

    @staticmethod
    def init(con):
        # startup code
        con.execute('''
            CREATE TABLE `Project` (
            `Id`	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
            `Name`	TEXT NOT NULL UNIQUE,
            `Acronym`	TEXT NOT NULL,
            `Status`	TEXT NOT NULL
        );''')
        con.execute('''
            CREATE TABLE `Org` (
            `Id`	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
            `ProjectId`	INTEGER NOT NULL,
            `Login`	TEXT NOT NULL,
            `Password`	TEXT NOT NULL,
            `Token`	TEXT NOT NULL,
            `Description`	TEXT
        );''')
        # frame = number of minutes between builds
        con.execute('''
            CREATE TABLE `Plan` (
            `Id`	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
            `ProjectId`	INTEGER NOT NULL,
            `OrgId`	INTEGER NOT NULL,
            `Type`	TEXT NOT NULL,
            `Active`	INTEGER NOT NULL,
            `Frame` INTEGER,
            `TotalBuilds`	INTEGER,
            `TotalSuccessBuilds`	INTEGER,
            `TotalFailBuilds`	INTEGER,
            `LastBuildSucceeded`	TEXT
        );''')
        con.execute('''
            CREATE TABLE `Build` (
            `Id`	INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE,
            `Number`	INTEGER NOT NULL,
            `ProjectId`	INTEGER NOT NULL,
            `OrgId`	INTEGER NOT NULL,
            `PlanId`	INTEGER NOT NULL,
            `Status`    TEXT NOT NULL,
            `BuildLog`	TEXT NOT NULL,
            `BuildResult`	INTEGER NOT NULL,
            `ErrorCount`	INTEGER NOT NULL,
            `TimeElapsed`	INTEGER NOT NULL
        );''')
        con.commit()

    # BEGIN READ SECTION
    # get everything
    def query_all(self, table_name):
        c = self.con.cursor()
        try:
            c.execute('SELECT * FROM ' + table_name)
        except Exception as e:
            raise e

        query_result = c.fetchall()

        return query_result

    def get_projects(self):
        return self.query_all('Project')

    def get_builds(self):
        return self.query_all('Build')

    def get_orgs(self):
        return self.query_all('Org')

    def get_plans(self):
        return self.query_all('Plan')

    def query_plan_builds(self, plan_id):
        c = self.con.cursor()
        try:
            c.execute('SELECT * FROM Build WHERE PlanId = ' + str(plan_id))
        except Exception as e:
            raise e

        query_result = c.fetchall()
        if len(query_result) > 0:
            return query_result
        else:
            return None

    # get all active (1) plans for the Scheduler
    def sc_get_plans(self):
        c = self.con.cursor()
        try:
            # 0 = False
            # 1 = True
            c.execute('SELECT * FROM Plan WHERE Active=0;')
            return c.fetchall()
        except Exception as e:
            raise e

    def get_org(self, org_id):
        c = self.con.cursor()
        try:
            c.execute('SELECT Login FROM Org WHERE Id = ' + str(org_id) + ';')
            return c.fetchone()
        except Exception as e:
            raise e

    def get_org_info(self, org_id):
        c = self.con.cursor()
        try:
            c.execute('SELECT * FROM Org WHERE Id = ' + str(org_id) + ';')
            return c.fetchone()
        except Exception as e:
            raise e

    def get_project_name(self, project_id):
        c = self.con.cursor()
        try:
            c.execute('SELECT Name FROM Project WHERE Id = ' + str(project_id) + ';')
            return c.fetchone()
        except Exception as e:
            raise e

    def get_project_info(self, project_id):
        c = self.con.cursor()
        try:
            c.execute('SELECT * FROM Project WHERE Id = ' + str(project_id))
            return c.fetchone()
        except Exception as e:
            raise e

    # def get_project_plans(self, project_id):
    #     c = self.con.cursor()
    #     try:
    #         c.execute('')
    #         return c.fetchall()
    #     except Exception as e:
    #         raise e
    #
    # def get_latest_project_builds(self, project_id):
    #     c = self.con.cursor()
    #     try:
    #         c.execute('')
    #         return c.fetchall()
    #     except Exception as e:
    #         raise e

    def get_plan(self, plan_id):
        c = self.con.cursor()
        try:
            c.execute('SELECT * FROM Plan WHERE Id =' + str(plan_id))
            return c.fetchone()
        except Exception as e:
            raise e

    def get_plan_acronym(self, plan_id):
        c = self.con.cursor()
        try:
            c.execute('SELECT Project.Acronym FROM Project WHERE Project.Id = (SELECT Plan.ProjectId FROM Plan WHERE Id=' + str(plan_id) + ')')
            return c.fetchone()[0]
        except Exception as e:
            raise e

    def generate_build_number(self, plan_id):
        c = self.con.cursor()
        try:
            c.execute('SELECT Count(*) FROM Build WHERE Build.ProjectId=' + str(plan_id))
            return c.fetchone()[0]
        except Exception as e:
            raise e

    def get_average_build_time_by_plan(self, plan_id):
        c = self.con.cursor()
        try:
            c.execute('SELECT AVG(Build.TimeElapsed) FROM Build WHERE Build.PlanId=' + str(plan_id))
            return c.fetchone()[0]
        except Exception as e:
            raise e

    def get_last_insert_id(self):
        c = self.con.cursor()
        try:
            c.execute('SELECT last_insert_rowid()')
            return c.fetchone()[0]
        except Exception as e:
            raise e

    def get_build_id(self, plan_id):
        c = self.con.cursor()
        try:
            c.execute('SELECT Id FROM Build WHERE PlanId=' + str(plan_id) + ' AND Status=\'building\'')
            return c.fetchone()[0]

        except Exception as e:
            raise e

    def get_build_status(self, plan_id, build_id):
        c = self.con.cursor()
        try:
            c.execute('SELECT Status FROM Build WHERE PlanId=' + str(plan_id) + ' AND Id=' + str(build_id))
            # print()
            return c.fetchone()[0]
        except Exception as e:
            raise e

    def get_latest_completed_builds(self):
        # query for all builds with status = completed, but get
        # only the ones with highest Build.Number per plan
        c = self.con.cursor()
        try:
            # get every plan ID first
            c.execute('SELECT Id FROM Plan;')
            plans = c.fetchall()
            if plans is None:
                return None
            else:
                results = list()
                for plan in plans:
                    if plan[0] is not None:
                        c.execute('SELECT PlanId, MAX(Number) FROM Build WHERE PlanId=' + str(plan[0]) + ' AND Status=\'finished\'')
                        # example of result:
                        # PlanId - Max(Number)
                        # (1, 20)
                        result = c.fetchone()
                        results.append(result)
                return results

            #return c.fetchall()
        except Exception as e:
            raise e

    # END READ SECTION
    # BEGIN WRITING SECTION

    def add_new_project(self, project_name, project_acronym):
        self.con.execute('''INSERT INTO Project (Name, Acronym, Status) VALUES (?, ?, ?);''', (project_name, project_acronym, 'new'))
        self.con.commit()

    def add_new_plan(self, project_id, plan_type, org_id):
        self.con.execute('''
            INSERT INTO Plan (ProjectId, OrgId, Type, Active) VALUES
            (?, ?, ?, ?)''', (project_id, org_id, plan_type, False))
        self.con.commit()

    def add_new_org(self, org_login, org_password, org_sectoken, project_id):
        self.con.execute('''
            INSERT INTO Org (Login, Password, Token, ProjectId)
            VALUES (?, ?, ?, ?)''', (org_login, org_password, org_sectoken, project_id))
        self.con.commit()

    def add_build(self, plan_id, build_no, build_status, build_log, build_result, error_count, time_elapsed):
        # passing the plan ID and build NO
        # we need to query for the plan to get the
        # org and project ID
        c = self.con.cursor()
        try:
            c.execute('SELECT Plan.OrgId, Plan.ProjectId FROM Plan WHERE Id=' + str(plan_id))
            result = c.fetchone()

            self.con.execute('''INSERT INTO `Build` (
                            `Number`,
                            `ProjectId`,
                            `OrgId`,
                            `PlanId`,
                            `Status`,
                            `BuildLog`,
                            `BuildResult`,
                            `ErrorCount`,
                            `TimeElapsed`) VALUES
                            (?,?,?,?,?,?,?,?,?);''',
                             (build_no,
                              result[1],
                              result[0],
                              plan_id,
                              build_status,
                              build_log,
                              build_result,
                              error_count,
                              time_elapsed))
            self.con.commit()
            # print('ADDED NEW BUILD TO DB')
        except Exception as e:
            raise e

    # END WRITING SECTION
    # BEGIN UPDATE SECTION
    def update_project(self, project_id, project_name, project_acronym, project_status):
        try:
            # print('UPDATE Project SET Name=\'' + str(project_name) + '\' , Acronym=\'' + str(project_acronym) + '\' , Status=\'' + str(project_status) + '\'  WHERE Id=' + str(project_id))
            self.con.execute('UPDATE Project SET Name=\'' + str(project_name) + '\' , Acronym=\'' + str(project_acronym) + '\' , Status=\'' + str(project_status) + '\'  WHERE Id=' + str(project_id))
            # print('olar mundo')
            self.con.commit()
        except Exception as e:
            raise e

    def update_org(self, org_id, org_login, org_password, org_sectoken, org_desc):
        try:
            self.con.execute('UPDATE Org SET Login=\'' + org_login + '\', Password=\'' + org_password + '\', Token=\'' + org_sectoken + '\', Description=\'' + org_desc + '\' WHERE Id=' + str(org_id))
            self.con.commit()
        except Exception as e:
            raise e

    def set_finish_build(self, build_no, plan_id, time_elapsed):
        try:
            # print('Trying to finish build...')
            self.con.execute('UPDATE Build SET Status=\'finished\', TimeElapsed=' + str(time_elapsed) + ' WHERE Build.PlanId=' + str(plan_id) + ' AND Build.Number=' + str(build_no))
            self.con.commit()
            # print('Build finished.')
        except Exception as e:
            raise e

    def set_build_status(self, build_id, status):
        try:
            # print(build_id)
            # print(status)
            self.con.execute('UPDATE Build SET Status=\'' + str(status) + '\' WHERE Id=' + str(build_id))
            self.con.commit()
        except Exception as e:
            raise e

    def set_build_result(self, build_id, build_log):
        c = self.con.cursor()
        try:
            import base64
            log = base64.b64encode(build_log.encode()).decode('ascii')
            if build_id is None:
                build_id = ''
            print('UPDATE Build SET BuildLog=\'' + str(log) + '\' WHERE Build.Id=' + str(build_id))

            self.con.execute('UPDATE Build SET BuildLog=\'' + str(log) + '\' WHERE Id=' + str(build_id))
            self.con.commit()
        except Exception as e:
            raise e

    # END UPDATE SECTION