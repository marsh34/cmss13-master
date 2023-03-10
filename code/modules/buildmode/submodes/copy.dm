/datum/buildmode_mode/copy
	key = "copy"
	help = "Left Mouse Button on obj/turf/mob = Spawn a Copy of selected target\n\
	Right Mouse Button on obj/mob = Select target to copy"
	var/atom/movable/stored = null

/datum/buildmode_mode/copy/Destroy()
	stored = null
	return ..()

/datum/buildmode_mode/copy/when_clicked(client/c, params, obj/object)
	var/list/modifiers = params2list(params)

	if(LAZYACCESS(modifiers, LEFT_CLICK))
		var/turf/T = get_turf(object)
		if(stored)
			DuplicateObject(stored, perfectcopy=1, sameloc=0,newloc=T)
			log_admin("Build Mode: [key_name(c)] copied [stored] to [AREACOORD(object)]")
	else if(LAZYACCESS(modifiers, RIGHT_CLICK))
		if(ismovable(object)) // No copying turfs for now.
			to_chat(c, SPAN_NOTICE("[object] set as template."))
			stored = object
