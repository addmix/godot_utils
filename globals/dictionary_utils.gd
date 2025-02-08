class_name DictionaryUtils

## Modifies dictionary <code>a</code>, adding items from dictionary <code>b</code>. If <code>overwrite</code> is <code>true</code>, values from <code>b</code> will be used, however, nested dictionaries will not be overwritten, instead being recursively merged.
static func recursive_merge(a : Dictionary, b : Dictionary, overwrite : bool = false) -> void:
	for key in b.keys():
		
		if not a.has(key):
			a[key] = b[key]
		
		else:
			if a[key] is Dictionary and b[key] is Dictionary:
				recursive_merge(a[key], b[key], overwrite)
			#do the same thing for packed arrays?
			elif overwrite:
				a[key] = b[key]
