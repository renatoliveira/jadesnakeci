<html lang="en">
<head>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="/static/materialize/css/materialize.css">
    <meta charset="UTF-8">
    <title>Editing {{project_info[1]}}</title>
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
    <!-- about the project -->
    <div class="container">
        % if project_info is not None:
        <h3 class="center-align">{{project_info[1]}} [{{project_info[2]}}] -
            % print(project_info)
            % if project_info[3] == 'new':
            <span class="green-text">{{project_info[3]}}</span>
            % else:
            <span class="red-text">{{project_info[3]}}</span>
            % end
        </h3>
        <form method="POST" action="/e/project/{{project_info[0]}}">
            <div class="row">
                <div class="input-field col s4 offset-s4">
                    <input name="project_name" value="{{project_info[1]}}" id="project_name" type="text">
                    <label for="project_name">Name</label>
                </div>
            </div>
            <div class="row">
                <div class="input-field col s4 offset-s4">
                    <input name="project_acronym" value="{{project_info[2]}}" id="project_acronym" type="text">
                    <label for="project_acronym">Acronym</label>
                </div>
            </div>
            <div class="row">
                <div class="col s4 offset-s4">
                    <label>Project Status</label>
                    <select class="browser-default" name="project_status">
                        <option value="" disabled selected>Choose your option</option>
                        <option value="active">Active</option>
                        <option value="paused">Paused</option>
                        <option value="inactive">Inactive</option>
                    </select>
                </div>
            </div>
            <div style="display: none;">
                <input value="{{project_info[0]}}" name="project_id" type="text"/>
            </div>
            <div class="row">
                <div class="col s4 offset-s4 center-align">
                    <button class="btn waves-effect waves-light" type="submit">Update Project</button>
                </div>
            </div>
        </form>
        % end
    </div>
</body>
</html>