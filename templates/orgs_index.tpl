<html>
<head>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="/static/materialize/css/materialize.css">
    <meta charset="UTF-8">
    <title>Orgs</title>
</head>
<body>
    <script type="text/javascript" src="/static/jquery/jquery-2.1.4.min.js"></script>
    <script type="text/javascript" src="/static/materialize/js/materialize.min.js"></script>
    <nav>
        <div class="nav-wrapper teal accent-4">
            <ul id="nav-mobile" class="left hide-on-med-and-down">
                <li><a href="/">Home</a></li>
                <li><a href="/projects">Projects</a></li>
                <li><a href="/plans">Plans</a></li>
                <li class="active"><a href="/orgs">Orgs</a></li>
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
    <div id="orgs" class="container">
    % if orgs:
        <table>
            <thead>
                <tr>
                    <td>Login</td>
                    <td>Security Token</td>
                </tr>
            </thead>
            <tbody>
            % for p in range(len(orgs)):
                <tr>
                    <td>
                        <span class="col s4">{{orgs[p][2]}}</span>
                    </td>
                    <td>
                        <span class="col s4">{{orgs[p][4]}}</span>
                    </td>
                    <td>
                        <span class="col s4">{{orgs[p][5]}}</span>
                    </td>
                    <td>
                        <a href="/e/org/{{orgs[p][0]}}" class="waves-effect waves-light btn accent-4">edit</a>
                    </td>
                </tr>
            % end
            </tbody>
        </table>
    % end
    </div>
    <div id="new_orgs_registration" style="margin-top: 30px;">
        <div class="container center-align">
            <a href="/neworg" class="waves-effect waves-light btn green accent-4"><i class="material-icons left"></i>new org</a>
        </div>
    </div>
</body>
</html>