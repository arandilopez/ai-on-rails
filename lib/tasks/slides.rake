namespace :slides do
  task :build do
    puts "Building slides..."
    `marp ./slides/deck.md --theme ./slides/dracula.css --html`
  end
end
