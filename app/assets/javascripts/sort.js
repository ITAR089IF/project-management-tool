$(document).ready(function() {
  Sortable.create(incomplete_tasks, { handle: '.glyphicon-move', animation: 150 });
  Sortable.create(complete_tasks, { handle: '.glyphicon-move', animation: 150 });
});
