ActiveAdmin.register Product do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :name, :description, :price, :category
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :description, :price, :category]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  permit_params :name, :description, :price, :category, :image, :on_sale
  filter :on_sale, as: :boolean

  index do
      selectable_column
      id_column
      column :image do |product|
        if product.image.attached?
          image_tag url_for(product.image), size: "50x50"
        end
      end
      column :name
      column :category
      column :price
      actions
    end

    filter :name
    filter :category
    filter :price

    form do |f|
      f.inputs do
        f.input :name
        f.input :description
        f.input :price
        f.input :category, as: :select, collection: [ "Burgers", "Sides", "Drinks", "Combos" ]
        f.input :on_sale, as: :select, collection: [["Yes", true], ["No", false]], label: "On Sale?"
        f.input :image, as: :file, hint: f.object.image.attached? ? image_tag(url_for(f.object.image), size: "100x100") : content_tag(:span, "No image uploaded")
      end
      f.actions
    end

    show do
      attributes_table do
        row :name
        row :description
        row :price
        row :category
        row :image do |product|
          if product.image.attached?
            image_tag url_for(product.image), size: "300x300"
          else
            "No image"
          end
        end
        row :created_at
        row :updated_at
      end
    end
end
