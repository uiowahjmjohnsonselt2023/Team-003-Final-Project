$(document).on('turbolinks:load', function() {
    $(document).on('submit', '#new_message', function(e) {
        e.preventDefault();
        $.ajax({
            url: $(this).attr('action'),
            type: 'POST',
            data: $(this).serialize(),
            success: function(data) {
                // Success logic here
            },
            error: function() {
                alert("There was an error sending your message.");
            }
        });
    });
});