{ application, my_app,
  [{descriptor, "my app"},
   {vsn, "0.0.1"},
   {modules, [cb_mod, my_app]},
   {registered, [echo]},
   {applications, [kernel, stdlib]},
   {mod, {cb_mod, []}}
  ]}.
	
