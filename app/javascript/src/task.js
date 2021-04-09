$(() =>
  $(document).on('click', '.visibility_button', changeVisibility)
)

function changeVisibility() {
  let deadline_div = $(this).parent().parent().find('.task_deadline')
  let deadline_input = deadline_div.find('#task_deadline')

  if($(deadline_div).is(':visible')){
    deadline_div.hide()
    deadline_input.prop('disabled', true)
  } else {
    deadline_div.show()
    deadline_input.removeAttr('disabled')
    deadline_input.removeAttr('readonly')
  }
}
