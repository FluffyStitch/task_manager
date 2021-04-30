$(() => {
  $(document).on('click', '.visibility_button', changeVisibility)
  $(document).on('click', '#task_completed', changeCompleted)
})

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

function changeCompleted() {
  let task_id = $(this).attr('task_id')
  $.ajax(`tasks/${task_id}/complete`, { type: 'PUT' })
}
