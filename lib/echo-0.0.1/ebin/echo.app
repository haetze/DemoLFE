{ application, echo,
  [{descriptor, "echo"},
   {vsn, "0.0.1"},
   {modules, [echo, echo_sup, echo_gen, echo_service_sup]},
   {registered, [echo, echo_sup]},
   {applications, [kernel, stdlib]},
   {mod, {echo, []}}
  ]}.
	
