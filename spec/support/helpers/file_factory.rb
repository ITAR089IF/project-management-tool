class FileFactory
  def self.random_file
    file = Dir["#{Rails.root}/spec/fixtures/files/*"].sample
    {
      io: File.open(Rails.root.join('spec', 'fixtures', 'files', file)),
      filename: file
    }
  end
end
