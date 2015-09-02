<html>
<head>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="/static/materialize/css/materialize.css">
    <meta charset="UTF-8">
    <title>Plans</title>
</head>
<body>
    <script type="text/javascript" src="/static/jquery/jquery-2.1.4.min.js"></script>
    <script type="text/javascript" src="/static/materialize/js/materialize.min.js"></script>
    <nav>
        <div class="nav-wrapper teal accent-4">
            <ul id="nav-mobile" class="left hide-on-med-and-down">
                <li><a href="/">Home</a></li>
                <li><a href="/projects">Projects</a></li>
                <li class="active"><a href="/plans">Plans</a></li>
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
    <div class="row">
    <table class="col s6 offset-s3">
            <thead>
                <tr>
                    <th data-field="type">Type</th>
                    <th data-field="project">Project</th>
                    <th data-field="org">Org</th>
                    <th data-field="active">Status</th>
                </tr>
            </thead>
            <tbody>
                % for p in range(len(plans)):
                <tr>
                    % if plans[p][3] == 'deploy':
                    <td><i class="material-icons" style="cursor:default;">backup</i><span style="padding-left: 10px;">Deploy</span></td>
                    % else:
                    <td><i class="material-icons" style="cursor:default;">cloud_download</i><span style="padding-left: 10px;">Retrieve</span></td>
                    % end
                    <td>{{db.get_project_name(plans[p][1])[0]}}</td>
                    <td>{{db.get_org(plans[p][2])[0]}}</td>
                    % if plans[p][4] == 0:
                    <td><span class="red-text text-accent-4">Disabled</span></td>
                    % else:
                    <td><span class="green-text text-accent-4">Enabled</span></td>
                    % end
                    <td>
                        % if plans[p][4] == 0:
                        <span class="grey-text text-darken-1"></span><i class="small material-icons" style="cursor:default;">play_circle_outline</i>
                        <span class="grey-text text-darken-1"></span><i class="small material-icons" style="cursor:default;">pause_circle_outline</i>
                        % else:
                        <span class="blue-text text-accent-4"></span><a href="/run_plan/{{plans[p][0]}}"><i class="small material-icons">play_circle_outline</i></a>
                        <span class="blue-text text-accent-4"></span><a href="/pause_plan/{{plans[p][0]}}"><i class="small material-icons">pause_circle_outline</i></a>
                        % end
                    </td>
                </tr>
                % end
            </tbody>
        </table>
    </div>
    <div class="row">
        <div class="container center-align">
            <a href="/newplan" class="waves-effect waves-light btn green accent-4"><i class="material-icons left"></i>new plan</a>
        </div>
    </div>
</body>
</html>