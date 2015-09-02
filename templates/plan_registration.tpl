<html>
<head>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="/static/materialize/css/materialize.css">
    <meta charset="UTF-8">
    <title>New Plant</title>
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
    <form action="/newplan" method="POST" class="col s4" style="padding-top: 20px;">
        <div class="container">
            <div class="row">
                <div class="col s4 offset-s4">
                    <label>Project</label>
                    <select name="projectid" class="browser-default">
                        <option value="" disabled selected>Select a project for this plan</option>
                        % for p in range(len(projects)):
                        <option value="{{projects[p][0]}}">{{projects[p][1]}}</option>
                        % end
                    </select>
                </div>
            </div>
            <div class="row">
                <div class="col s4 offset-s4">
                    <label>Organization</label>
                    <select name="orgid" class="browser-default">
                        <option value="orgid" disabled selected>Select an organization for this plan</option>
                        % for o in range(len(orgs)):
                        <option value="{{orgs[o][0]}}">{{orgs[o][2]}}</option>
                        % end
                    </select>
                </div>
            </div>
            <div class="row">
                <div class="col s4 offset-s4">
                    <label>Type</label>
                    <select name="type" class="browser-default">
                        <option value="" disabled selected>Select a type of plan</option>
                        <option value="retrieve">Retrieve</option>
                        <option value="deploy">Deploy</option>
                    </select>
                </div>
            </div>
        </div>
        <div class="container center-align">
            <button class="waves-effect waves-light btn green accent-4"><i class="material-icons left"></i>add plan</button>
            <a href="/" class="waves-effect waves-light btn red accent-4"><i class="material-icons left"></i>cancel</a>
        </div>
    </form>
</body>
</html>