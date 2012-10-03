require 'vimrunner'

describe "spec runner plugin" do
  before(:all) do
    @vim = Vimrunner.start
    @vim.add_plugin(File.join(File.dirname(__FILE__), '..'), 'plugin/rspec-runner.vim')
  end

  after(:all) do
    @vim.kill
  end

  it "says hello" do
    @vim.command('echo FindGemfile()').should == "hello"
  end
end
