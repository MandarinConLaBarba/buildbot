
# order is important in the configuration stage
# so we need to have this provider defined in routes.coffee
# this provider holds the list of states (which unfortunatly not a feature of ui-router)
# so that top menu can be autogenerated
angular.module('app').provider 'topMenuStates', ->
    states = []
    @state = (state) ->
        states.push(state)
    @$get = ->
        states
    @
angular.module('app').config [ "$stateProvider", "$urlRouterProvider", "topMenuStatesProvider"
    ($stateProvider, $urlRouterProvider, topMenuStatesProvider) ->

        $urlRouterProvider.otherwise('/');

        # by convention, in this module the key of the mapping
        # is the name of the template and of the controller
        # If the route has a caption, it is linked in the top menu
        # The route is configured in $routeProvider
        default_routes =
            home:
                caption: "Home"
                url: "/"
            builders:
                caption: "Builders"
                url: "/builders"
        #    lastbuilds:
        #        caption: "Last Builds"
        #        url: "/lastbuilds"
            changes:
                caption: "Last Changes"
                url: "/changes"
        #    buildslaves:
        #        caption: "Build Slaves"
        #        url: "/buildslaves"
        #    buildmasters:
        #        caption: "Build Masters"
        #        url: "/buildmasters"
            schedulers:
                caption: "Schedulers"
                url: "/schedulers"
        #    users:
        #        caption: "Users"
        #        url: "/users"
        #    admin:
        #        caption: "Admin"
        #        url: "/admin"
            about:
                caption: "About"
                url: "/about"


            builder:
                url: "/builders/:builder"
                tabid: "builders"
            build:
                url: "/builders/:builder/build/:build"
                tabid: "builders"
            step:
                url: "/builders/:builder/build/:build/steps/:step"
                tabid: "builders"
            log:
                url: "/builders/:builder/build/:build/steps/:step/logs/:log"
                tabid: "builders"

            buildslave:
                url: "/buildslaves/:buildslave"
                tabid: "buildslaves"
            buildmaster:
                url: "/buildmasters/:buildmaster"
                tabid: "buildmasters"
            user:
                url: "/users/:user"
                tabid: "users"

            editconf:
                url: "/admin/:conffile"
                tabid: "admin"

        for id, cfg of default_routes
            cfg.tabid ?= id
            cfg.tabhash = "##{id}"
            state =
                controller: "#{id}Controller"
                templateUrl: "views/#{id}.html"
                name: id
                url: cfg.url
                data: cfg

            $stateProvider.state(state)
            topMenuStatesProvider.state(state)
]