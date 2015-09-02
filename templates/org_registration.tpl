<html>
<head>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="/static/materialize/css/materialize.css">
    <meta charset="UTF-8">
    <title>New Org</title>
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
    <div class="container">
        <div>
            <form action="/neworg" method="POST">
                <div>
                    <h4 style="padding-bottom: 20px;">Add a new Salesforce organization</h4>
                    <div class="input-field">
                        <input placeholder="admin@salesforce.org" id="username" name="username" type="text" class="validate"/>
                        <label for="username">Login</label>
                    </div>
                    <div class="input-field">
                        <input placeholder="Admin's Password" id="password" name="password" type="password" class="validate"/>
                        <label for="password">Password</label>
                    </div>
                    <div class="input-field">
                        <input placeholder="25-digit Security Token" id="sectoken" name="sectoken" type="text" length="25" min-length="25"/>
                    </div>
                    <div class="row">
                        <div class="col s4">
                            <label>Project</label>
                            <select name="projectid" class="browser-default">
                                <option value="" disabled selected>Select a project for this plan</option>
                                % for p in range(len(projects)):
                                <option value="{{projects[p][0]}}">{{projects[p][1]}}</option>
                                % end
                            </select>
                        </div>
                    </div>
                </div>
                <div class="container center-align">
                    <button class="waves-effect waves-light btn-large green accent-4"><i class="material-icons left"></i>add new org</button>
                    <a href="/orgs" class="waves-effect waves-light btn-large red accent-4"><i class="material-icons left"></i>cancel</a>
                </div>
            </form>
        </div>
    </div>
</body>
</html>