require 'vimrunner'

describe "spec runner plugin" do
  let (:path_to_plugin) { File.expand_path(File.join(File.dirname(__FILE__), '..')) }
  before(:all) do
    @vim = Vimrunner.start
    @vim.add_plugin(path_to_plugin, 'plugin/rspec-runner.vim')
  end

  after(:all) do
    @vim.kill
  end

  it "returns the path to the file containing the custom formatter" do
    path_to_formatter = File.expand_path(File.join(path_to_plugin, 'plugin', 'formatter', 'vim_quickfix_formatter.rb'))
    @vim.command("echo rspecrunner#PathToFormatter()").should eq path_to_formatter
  end
end
