<html>
<head>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="/static/materialize/css/materialize.css">
    <meta charset="UTF-8">
    <title>JadeSnake CI Home</title>
</head>
<body class="red darken-4">
    <script type="text/javascript" src="/static/jquery/jquery-2.1.4.min.js"></script>
    <script type="text/javascript" src="/static/materialize/js/materialize.min.js"></script>
    <nav>
        <div class="nav-wrapper red accent-4">
            <ul id="nav-mobile" class="left hide-on-med-and-down">
                <li><a href="/">Home</a></li>
                <li><a href="/projects">Projects</a></li>
                <li><a href="/plans">Plans</a></li>
                <li><a href="/orgs">Orgs</a></li>
                <li><a href="/builds">Builds</a></li>
            </ul>
        </div>
    </nav>
    <div class="container">
        <div class="center-align red-text text-lighten-5">
            <h1>{{str(code)}}</h1>
            % if code == 404:
            <p>{{str(error_info.body)}}</p>
            % end
            % if code != 404:
            <div class="card-panel">
                <span class="black-text">{{error_info.body}}</span>
            </div>
            % end
        </div>
    </div>
</body>
</html>