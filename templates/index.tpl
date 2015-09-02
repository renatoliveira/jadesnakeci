<!DOCTYPE html>
<html lang="en">
<head>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="/static/materialize/css/materialize.css">
    <meta charset="UTF-8">
    <title>JadeSnake CI Home</title>
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
    <div class="row">
        <ul class="col s10 offset-s1 collection">
            <li class="collection-item">
                <h5>Plan X <i class="material-icons green-text" style="margin-left: 1%;">check</i></h5>
                <p>Plan X description
                    <a href="#!" class="secondary-content"><i class="small material-icons black-text">stop</i></a>
                    <a href="#!" class="secondary-content"><i class="small material-icons black-text">play_arrow</i></a>
                </p>
            </li>
            <li class="collection-item">
                <h5>Plan X <i class="material-icons red-text" style="margin-left: 1%;">clear</i></h5>
                <p>Plan X description
                    <a href="#!" class="secondary-content"><i class="small material-icons black-text">stop</i></a>
                    <a href="#!" class="secondary-content"><i class="small material-icons black-text">play_arrow</i></a>
                    <ul class="collapsible" data-collapsible="accordion">
                        <li>
                            <div class="collapsible-header">ERROR_CODE</div>
                            <div class="collapsible-body"><p>Error description. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p></div>
                        </li>
                    </ul>
                </p>
            </li>
        </ul>
    </div>
</body>
</html>