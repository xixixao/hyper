# Require.js config
require
  urlArgs: "b=#{(new Date()).getTime()}"
  paths:
    hyper: 'vendor/hyper/hyper'
  , ['app/main'], (main) -> main()