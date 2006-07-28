(
	var object_list, object_dict;
	var ob_vim_file, ob_comp_file, tags_file;

	//open the files
	//for supercollider_objects.vim
	ob_vim_file = File("SCVIM_DIR".getenv ++ "/syntax/supercollider_objects.vim","w");
	//for TAGS_SCDEF (object definitions)
	tags_file = File("SCVIM_DIR".getenv ++ "/TAGS_SCDEF","w");
	//for object completion && object lookup in the SChelp function
	ob_comp_file = File("SCVIM_DIR".getenv ++ "/sc_object_completion","w");

	ob_vim_file.write("syn keyword\tscObject\t");
	object_list = SortedList.new(0);
	object_dict = Dictionary.new;
	//add Object itself
	object_list = object_list.add(Object.asString);
	object_dict.add(Object.asString -> Object);
	//sort the Objects (add to a sorted list)
	Object.allSubclasses.do(
		{|i| 
			object_list = object_list.add(i.asString);
			object_dict.add(i.asString -> i);
		});
	//go through the Objects in order and write what needs to be written to the files
	object_list.do(
		{|ob_string|
			ob_vim_file.write(ob_string ++ " ");
			/* disregard any Meta_ Classes */
			if(ob_string.find("Meta_",false,0).isNil,
				{ob_comp_file.write(ob_string ++ "\n")});
			tags_file.write("SCDEF:" ++ 
					ob_string ++ 
					"\t" ++ object_dict.at(ob_string).filenameSymbol ++ 
					"\tgo " ++ 
					(object_dict.at(ob_string).charPos + 1) ++ "\n");
		});
	//add some extra new lines
	ob_vim_file.write("\n\n");
	ob_vim_file.close;
	tags_file.close;
	ob_comp_file.close;
	"SCVIM files written".postln;
)
