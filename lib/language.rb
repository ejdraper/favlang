class Language
  def self.favourite_language(repos)
    repos
      .reject { |repo| repo['primaryLanguage'].nil? }
      .inject({}) do |hash, repo|
        hash[repo['primaryLanguage']['name']] ||= 0
        hash[repo['primaryLanguage']['name']] += 1
        hash
      end.sort { |a,b| b.last <=> a.last }[0][0]
  end
end