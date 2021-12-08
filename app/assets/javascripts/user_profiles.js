$(document).on('turbolinks:load', function() {
  $('#update_button').click(function () {
    // Tomar la información del form
    var first_name_field = $('.first_name_field');
    var last_name_field = $('.last_name_field');
    var year_bithdate_field = $('#user_birthdate_1i');
    var month_bithdate_field = $('#user_birthdate_2i');
    var day_bithdate_field = $('#user_birthdate_3i');

    //Crear un hash con los valores de la información tomada del form
    var data = {
      first_name: first_name_field.val(),
      last_name: last_name_field.val(),
      year_birthdate: year_bithdate_field.val(),
      month_birthdate: month_bithdate_field.val(),
      day_birthdate: day_bithdate_field.val()
    };

    console.log(data)
    
    // LLamar al controller con la data
    Rails.ajax({
      url: "/edit_ajax",
      type: "put",
      data: new URLSearchParams(data).toString(),
      success: (response) => {
        
        //Modificar la vista
        $('#first_name').html(response.first_name);
        $('#last_name').html(response.last_name);
        $('#birthdate').html(response.birthdate);
        $('#editUserModal').modal('hide');
        
        console.log(response);
      },
      error: (response) => {
        //Mostrar el error y mantener la vista igual
        alert(response.message);
        console.log(response.message);
      }
    })
  })
});