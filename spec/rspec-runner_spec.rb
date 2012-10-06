require 'vimrunner'

describe "spec runner plugin" do
  let (:path_to_plugin) { File.expand_path(File.join(File.dirname(__FILE__), '..')) }
  let (:path_to_formatter) { File.expand_path(File.join(path_to_plugin, 'plugin', 'formatter', 'vim_quickfix_formatter.rb')) }
  before(:all) do
    @vim = Vimrunner.start
    @vim.add_plugin(path_to_plugin, 'plugin/rspec-runner.vim')
  end

  after(:all) do
    @vim.kill
  end

  it "returns the path to the file containing the custom formatter for the relevant version of Rspec" do
    @vim.command('echo rspecrunner#PathToFormatter("2.x")').should eq path_to_formatter

    path_to_rspec_1_formatter = File.expand_path(File.join(path_to_plugin, 'plugin', 'formatter', 'vim_quickfix_formatter_rspec1.rb'))
    @vim.command('echo rspecrunner#PathToFormatter("1.x")').should eq path_to_rspec_1_formatter
  end

  it "returns the class of the selected formatter" do
    @vim.command(%Q{echo rspecrunner#FormatterClass("#{path_to_formatter}")}).should eq "VimQuickfixFormatter"
  end

  it "returns the current version of Rspec" do
    # TODO: before you're done figure out if you want this to be more granular - e.g. rspec 1 checks
    @vim.command("echo rspecrunner#GetExecutable()").should eq "2.x"
  end

  it "returns the name of the spec file to be run" do
    require 'tempfile'
    file = Tempfile.new('vim-rspec-runner')
    @vim.edit(file.path)
    @vim.command("echo rspecrunner#SpecFilePath()").should eq file.path
    file.unlink
  end
end
