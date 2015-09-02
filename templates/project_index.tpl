<html>
<head>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="/static/materialize/css/materialize.css">
    <meta charset="UTF-8">
    <title>Projects</title>
</head>
<body>
    <script type="text/javascript" src="/static/jquery/jquery-2.1.4.min.js"></script>
    <script type="text/javascript" src="/static/materialize/js/materialize.min.js"></script>
    <nav>
        <div class="nav-wrapper teal accent-4">
            <ul id="nav-mobile" class="left hide-on-med-and-down">
                <li><a href="/">Home</a></li>
                <li class="active"><a href="/projects">Projects</a></li>
                <li><a href="/plans">Plans</a></li>
                <li><a href="/orgs">Orgs</a></li>
                <li><a href="/builds">Builds</a></li>
            </ul>
        </div>
    </nav>
    <div id="system_messages" class="row" style="margin-bottom: 0px;">
        % for sm in range(len(messages)):
        <div class="card-panel cyan lighten-2 col s8 offset-s2">
            <p><span class="cyan-text text-lighten-5"><i class="material-icons" style="padding-right: 10px;">info_outline</i>{{messages[sm]}}</span></p>
        </div>
        % end
    </div>
    <div id="system_warnings" class="row" style="margin-bottom: 0px;">
        % for sw in range(len(warnings)):
        <div class="card-panel yellow lighten-2 col s8 offset-s2">
            <p><span class="yellow-text text-darken-4"><i class="material-icons" style="padding-right: 10px;">warning</i>{{warnings[sw]}}</span></p>
        </div>
        % end
    </div>
    <div id="system_errors" class="row" style="margin-bottom: 0px;">
        % for se in range(len(errors)):
        <div class="card-panel red lighten-2 col s8 offset-s2">
            <p><span class="red-text text-lighten-5"><i class="material-icons" style="padding-right: 10px;">error_outline</i>{{errors[se]}}</span></p>
        </div>
        % end
    </div>
    <!-- List the projects -->
    <div id="projects" class="container">
    % if projects:
        <ul class="collection">
        % for p in range(len(projects)):
            <li class="collection-item">
                <div>
                    <p><h5 class="col s4">{{projects[p][1]}} ({{projects[p][2]}})</h5></p>
                    % if projects[p][3] == 'new':
                        <p>Status: <span class="blue-text text-accent-4">{{projects[p][3]}}</span></p>
                    % elif projects[p][3] == 'inactive':
                        <p>Status: <span class="red-text text-accent-4">{{projects[p][3]}}</span></p>
                    % elif projects[p][3] == 'active':
                        <p>Status: <span class="green-text text-accent-4">{{projects[p][3]}}</span></p>
                    % elif projects[p][3] == 'paused':
                        <p>Status: <span class="yellow-text text-accent-4">{{projects[p][3]}}</span></p>
                    % end
                    % number_of_plans = 0
                    % for plan in range(len(plans)):
                        % if plans[plan][1] == projects[p][0]:
                            % number_of_plans += 1
                        % end
                    % end
                        <p>Plans: {{number_of_plans}}</p>
                </div>
                <div class="right-align">
                    <a class="waves-effect waves-light btn" href="/e/project/{{projects[p][0]}}">Edit Project</a>
                    <!--<a class="waves-effect waves-light red btn" href="/e/project/{{projects[p][0]}}">remove Project</a>-->
                </div>
            </li>
        % end
        </ul>
    % end
    </div>
    <!-- buttons to add new projects -->
    <div id="new_projects_registration" style="margin-top: 30px;">
        <div class="container center-align">
            <a href="/newproject" class="waves-effect waves-light btn green accent-4"><i class="material-icons left"></i>new project</a>
        </div>
    </div>
</body>
</html>