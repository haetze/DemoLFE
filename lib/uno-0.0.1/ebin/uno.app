{ application, uno,
  [{description, "uno server"},
   {vsn, "0.0.1"},
   {modules, [uno, uno_supervisor]}, % modules that are part of the application
   {registered, []}, %registered processes 
   {applications, [kernel, stdlib, sasl]}, %applications req
   {env, []}, %env variables and default value
   {mod, {uno, []}} %callback modules
  ]}.
