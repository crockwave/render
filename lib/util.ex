defmodule Render.Util do
	require Logger

  @grades ["KG", "1st", "2nd", "3rd", "4th", "5th", "6th", "7th",
    "8th", "9th", "10th", "11th", "12th", "Post K-12", "Pro Dev"]

  @subjects ["Architecture", "Art", "Biology", "Business", "Chemistry", "Computer Science",
    "Design", "Education", "Engineering", "Geography", "Geology", "History", "Journalism", 
    "Information Tech", "Language Arts", "Life Arts", "Math", "Moral Science", "Other", "Performing Arts", "Philosophy",
    "Phys Ed", "Physics", "Prof Development", "Religion", "Science", "Sociology", "Special Education",
    "Specialty", "World Languages"]

  @ordered_grade_keys ["k", "1", "2", "3", "4", "5", "6", "7",
     "8", "9", "10", "11", "12", "pk", "pd"]

  @ordered_subject_keys ["arch", "art", "bio", "bus", "chem", "comp", "des", "edu",
   "eng", "geog", "geol", "his", "jou", "it", "la", "life", "math", "moral", "other", "perf", "phil", 
   "pe", "phys", "pd", "reli", "sci", "soc", "spec-ed", "specialty", "world"]

  # @colors %{"foreground" => "#fff", "background" => "#e7facc", "accent" => "10d17d", "brand" => "287164", "selected" => "#e7facc", "archived" => "f0f0f0"}
  
  def ordered_grade_keys() do
   	@ordered_grade_keys
  end

  def ordered_subject_keys() do
   	@ordered_subject_keys
  end

  def class_selected?(class_id, selected_class) do
  	# IO.puts("Util class_selected?, class_id: #{inspect class_id}, selected_class: #{inspect selected_class}")
    result =
    if class_id == String.to_integer(selected_class) do
    	# IO.puts("Util class_selected?, result: true")
      true
    else
    	# IO.puts("Util class_selected?, result: false")
      false
    end
    result
  end

  def convert_bool!("true"), do: true
  
  def convert_bool!("false"), do: false

	def site_logo() do
		"/images/render_logo.png"
	end

	def default_avatar() do
		"generic_avatar.png"
	end

	def default_username() do
		"Your Username"
	end

	def uploads_path() do
		Path.join([:code.priv_dir(:render), "static", "uploads/"])
	end

	def get_avatar(avatar) do
		# converts avatar filename to renderable avatar path
	    avatar = normalize_avatar(avatar)
	    # path = uploads_path
		if File.exists?(Path.join([uploads_path(), avatar])) do
			Path.join(["/uploads/", avatar])
		else
			"/uploads/generic_avatar.png"
		end
	end

	def get_username(display_name) do
	    # returns renderable username
	    if display_name == "" || display_name == nil do
	      default_username()
	    else
	      display_name
	    end
	end

	def remove_old_avatar(avatar_path) do
		# tries to remove old avatar from uploads dir
		avatar =
			avatar_path
			|> Path.basename()
			|> normalize_avatar()

		if File.exists?(Path.join([uploads_path(), avatar])) && avatar != default_avatar() do
			File.rm!(Path.join([uploads_path(), avatar]))
		end
	end

	def get_selected_grades(grades) do
		result = []
		grade_list =
		for key <- @ordered_grade_keys do 
	    state = Map.get(grades, key)
			if state == true do
				text = get_button_text("grades", key)
				[text | result]
			end
		end
		grade_list_flattened = List.flatten(grade_list)
		grade_list_filtered = Enum.reject(grade_list_flattened, &is_nil/1)
		convert_to_cds(grade_list_filtered)
	end

	def get_selected_subjects(subjects) do
		result = []
		subject_list =
		for key <- @ordered_subject_keys do 
	    state = Map.get(subjects, key)
			if state == true do
				text = get_button_text("subjects", key)
				[text | result]
			end
		end
		subject_list_flattened = List.flatten(subject_list)
		subject_list_filtered = Enum.reject(subject_list_flattened, &is_nil/1)
		convert_to_cds(subject_list_filtered)
	end

  def get_button_text(type, key) do
  	# IO.puts "Util get_button_text, type: #{type}, key: #{key}"
    if type == "grades" do
      index = 
      Enum.find_index(@ordered_grade_keys, fn(element) ->
        element == key end)
      Enum.at(@grades, index)
    else 
      index =
      Enum.find_index(@ordered_subject_keys, fn(element) ->
        element == key end)
      Enum.at(@subjects, index)
    end
  end

  defp to_string_(%{} = m) do
      m
      |> Map.to_list()
      |> to_string_()
  end

  defp to_string_(l) when is_list(l) do
    values =
      l
      |> Enum.map(&to_string_/1)
      |> Enum.join(", ")

    "#{values}"
  end
  
  defp to_string_({k,v}) when is_atom(k) do
    "#{Atom.to_string(k)}=#{to_string_(v)}"
  end
  
  defp to_string_(s) when is_binary(s) do
    s
  end

  def convert_to_cds(l) when is_list(l) do
    to_string_(l)
  end


	defp normalize_avatar(avatar) do
	    if avatar == "" || avatar == nil do
	      default_avatar()
	    else
	      avatar
	    end		
	end
end
