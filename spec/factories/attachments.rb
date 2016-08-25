FactoryGirl.define do
  factory :image, class: Attachment do
    attachable nil
    file do
      Rack::Test::UploadedFile.new(
        File.join(
          Rails.root, 'spec', 'support', 'tasks', 'attachments', 'img.jpg')
        )
    end
  end

  factory :file, class: Attachment do
    attachable nil
    file do
      Rack::Test::UploadedFile.new(
        File.join(
          Rails.root, 'spec', 'support', 'tasks', 'attachments', 'file.txt')
        )
    end
  end
end
