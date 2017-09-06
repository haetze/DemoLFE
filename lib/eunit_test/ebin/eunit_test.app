{ application, NAME,
  [{description, DESCRIPTOPN},
   {vsn, "0.0.1"},
   {modules, []}, % modules that are part of the application
   {registered, []}, %registered processes 
   {applications, [kernel, stdlib]}, %applications req
   {env, []}, %env variables and default value
   {mod, {read_write, []}} %callback modules
  ]}.
