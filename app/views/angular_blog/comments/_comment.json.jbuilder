json.extract! comment, :id, :name, :email, :content, :display_email
json.timestamp comment.created_at.to_formatted_s(:long)