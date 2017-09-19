{ application, notifyHub,
  [{description, "Notification Hub on the Beam"},
   {vsn, "0.0.1"},
   {modules, [notifyHub, notifyHub_supervisor, sender, receiver]}, % modules that are part of the application
   {registered, []}, %registered processes 
   {applications, [kernel, stdlib, read_write, sasl]}, %applications req
   {env, []}, %env variables and default value
   {mod, {notifyHub, [notifyHub]}} %callback modules
  ]}.
