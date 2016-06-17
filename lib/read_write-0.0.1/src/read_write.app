{ application, read_write,
  [{description, "read_write"},
   {vsn, "0.0.1"},
   {modules, [read_write, read_write_sup, read_write_gen,
	     read_write_service_sup, read_write_service]},
   {registered, [read_write_gen, read_write_sup, read_write_service_sup,
		read_write_service]},
   {applications, [kernel, stdlib]},
   {mod, {read_write, []}}
  ]}.
	
