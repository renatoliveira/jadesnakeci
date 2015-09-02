<html>
<head>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="/static/materialize/css/materialize.css">
    <script type="text/javascript" src="/static/jquery/jquery-2.1.4.min.js"></script>

    <meta charset="UTF-8">
    <title>Builds</title>
    <script>
    // main function to call jquery
    $(document).ready(function(){
        // set an interval to make requests
        // every 2000 milliseconds (2 seconds)
        % for build in builds:
        setInterval('check_build{{build.build_id}}()', 2000)
        console.log('setting checker for build {{build.build_id}}...')
        % end
    })

    % for build in builds:
    function check_build{{build.build_id}}(){
        var build_id = '{{build.build_id}}';
        $.ajax({
            type: 'GET',
            url: 'checkplan/{{build.plan_id}}/{{build.build_id}}',
            success: function(response){
                if (response == '0'){
                    // window.location = '/builds';
                    // change class to 'determinate' and add style.width = 100%
                    $('#progress_bar_{{build.build_id}}').removeClass();
                    $('#progress_bar_{{build.build_id}}').addClass('determinate green').css('width', '100%');
                    $('#status_{{build.build_id}}').text('Completed {{build.plan_acronym}} - Build #{{build.build_no}}!');
                    console.log('added class!');
                }
                // reload the page if the id comes blank
                if (build_id == 'None'){
                    window.location = '/builds';
                }
                // console.log('Response: ' + response);
                // console.log('Build ID: ' + build_id);
            }
        });
    }
    % end
    </script>
</head>
<body>
    <script type="text/javascript" src="/static/materialize/js/materialize.min.js"></script>
    <nav>
        <div class="nav-wrapper teal accent-4">
            <ul id="nav-mobile" class="left hide-on-med-and-down">
                <li><a href="/">Home</a></li>
                <li><a href="/projects">Projects</a></li>
                <li><a href="/plans">Plans</a></li>
                <li><a href="/orgs">Orgs</a></li>
                <li class="active"><a href="/builds">Builds</a></li>
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
        % if len(builds) != 0:
        <ul class="collection">
            % for build in builds:
            <li id="build{{build.build_id}}" class="collection-item">
                <h4 id="status_{{build.build_id}}">Now building {{build.plan_acronym}} #{{build.build_no}}...</h4>
                <p>({{build.build_type.capitalize()}})
                    <div class="progress">
                        <!--<div class="determinate" style="width: 70%"></div>-->
                        <div id="progress_bar_{{build.build_id}}"  class="indeterminate"></div>
                    </div>
                    % if build.average_build_time:
                    Average build time is {{round(build.average_build_time, 1)}} seconds.
                    % else:
                    The average build time could not be calculated because it is the first time the plan runs.
                    % end
                </p>
            </li>
            % end
        </ul>
        % else:
        <div class="card teal darken-4">
            <div class="card-content white-text">
                <span class="card-title">There are no builds running right now</span>
                <p>You can start one by clicking the play button in one of the active plans in
                the 'Plans' tab.</p>
            </div>
            <div class="card-action">
                <a class="teal-text text-accent-4" href="/plans">View plans</a>
                <a class="teal-text text-accent-4" href="/">Back to home</a>
            </div>
        </div>
        % end
        % if len(completed_builds) > 0:
        <ul class="collection">
            % for build in completed_builds:
            <li class="collection-item green lighten-4">
                <h5>{{db.get_plan_acronym(build[0])}} <span class="green-text">#{{build[1]}}</span></h5>
            </li>
            % end
        </ul>
        % end
    </div>
</body>
</html>