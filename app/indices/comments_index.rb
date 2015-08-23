ThinkingSphinx::Index.define :comment, with: :active_record do
  # Fields
  indexes body
  indexes user_id, as: :author

  # Attributes
  has user_id, created_at, updated_at
end