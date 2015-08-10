shared_examples_for 'voteable' do
  it { should have_many(:votes).dependent(:destroy) }
end