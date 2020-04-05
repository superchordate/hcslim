.checkid = function(id) if(grepl('[ ]', id)) stop(glue::glue('
  hcslim: Invalid id [{id}]. Must be HTML-compatible. See https://stackoverflow.com/a/79022/4089266.
'))

.hcslimvars = new.env()
assign('.loadedpaths', c(), envir=.hcslimvars)
