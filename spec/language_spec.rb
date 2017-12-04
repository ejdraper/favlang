require 'bundler/setup'
Bundler.require(:test)

require File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib', 'language'))

repos1 = [
  {'primaryLanguage' => {'name' => 'Ruby'}},
  {'primaryLanguage' => {'name' => 'Java'}},
  {'primaryLanguage' => {'name' => 'Ruby'}}
]
repos2 = [
  {'primaryLanguage' => {'name' => 'C++'}},
  {'primaryLanguage' => {'name' => 'C++'}},
  {'primaryLanguage' => {'name' => 'C'}},
  {'primaryLanguage' => {'name' => 'Rust'}}
]
repos3 = [
  {'primaryLanguage' => {'name' => 'Perl'}},
  {'primaryLanguage' => {'name' => 'Python'}},
  {'primaryLanguage' => {'name' => 'Bash'}},
  {'primaryLanguage' => {'name' => 'Perl'}}
]

describe Language do
  context '#favourite_language' do
    it 'should figure out the favourite language from an array of repositories' do
      expect(Language.favourite_language(repos1)).to eq('Ruby')
      expect(Language.favourite_language(repos2)).to eq('C++')
      expect(Language.favourite_language(repos3)).to eq('Perl')
    end
  end
end