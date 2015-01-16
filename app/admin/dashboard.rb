ActiveAdmin.register_page "Dashboard" do
  sidebar :help do
    ul do
      li "First Line of Help"
    end
  end

  action_item do
    "Bla bla"
  end

  content do
    para "Hello World"
  end
end
