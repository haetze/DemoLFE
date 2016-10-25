(defmodule Concat
  (export-macro concat)
  (export
   )) 


(defmacro concat (f g args)
  `(apply ,f (list (apply ,g ,args))))