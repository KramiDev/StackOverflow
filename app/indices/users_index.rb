ThinkingSphinx::Index.define :user, with: :active_record do
  # Fields
  indexes email, sortable: true

  # Attributes
  has created_at, updated_at
end