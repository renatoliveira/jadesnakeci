<html lang="en">
<head>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="/static/materialize/css/materialize.css">
    <meta charset="UTF-8">
    <title>New Project</title>
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
    <div id="form_div" class="container col s8" style="margin-top: 50px;">
        <form class="col s6" action="/newproject" method="POST">
            <div class="row ">
                <h4 class="col offset-s2" style="padding-bottom: 20px;">Registering a new Project</h4>
                <div class="input-field col s6 offset-s2">
                    <input placeholder="Company Super CRM" id="project_name" name="project_name" type="text" class="validate"/>
                    <label for="project_name">Name</label>
                </div>
                <div class="input-field col s2">
                    <input placeholder="CSC" id="project_acronym" name="project_acronym" type="text" class="validate"/>
                    <label for="project_acronym">Acronym</label>
                </div>
            </div>
            <div class="container center-align">
                <button class="waves-effect waves-light btn-large green accent-4"><i class="material-icons left"></i>add project</button>
                <a href="/" class="waves-effect waves-light btn-large red accent-4"><i class="material-icons left"></i>cancel</a>
            </div>
        </form>
    </div>
</body>
</html>