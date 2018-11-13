document.addEventListener('turbolinks:load', () => {
  globalSearch();
});

function globalSearch() {

  var search = document.getElementById('search');
  var searchResults = document.getElementById('search-results');

  var workspaces = document.getElementById('workspaces');
  var projects = document.getElementById('projects');
  var tasks = document.getElementById('tasks');

  var workspacesBlock = document.getElementById('workspaces-block');
  var projectsBlock = document.getElementById('projects-block');
  var tasksBlock = document.getElementById('tasks-block');

  search.addEventListener('keyup', e => {

    var timer;

    clearTimeout(timer)
    timer = setTimeout(() => {
      if(e.target.value) {
        searchResults.style.display = 'block';

        fetch(Routes.account_search_index_path({ format: 'json', search: e.target.value }))
          .then(response => { return response.json() })
          .then(response => {
            display(response.workspaces, workspacesBlock, workspaces, 'WORKSPACES', 'name');
            display(response.projects, projectsBlock, projects, 'PROJECTS', 'name');
            display(response.tasks, tasksBlock, tasks, 'TASKS', 'title');
          })
          .catch(error => { alert(error) });
      } else {
        workspaces.innerHTML = '';
        projects.innerHTML = '';
        tasks.innerHTML = '';

        searchResults.style.display = 'none';
        workspacesBlock.style.display = 'none';
        projectsBlock.style.display = 'none';
        tasksBlock.style.display = 'none';
      }
    }, 300);
  })
}

function display(data, displayObject, innerObject, title, field) {
  if(data.length > 0) {
    displayObject.style.display = 'block';
    innerObject.innerHTML = jsonToHTML(data, title, field);
  } else {
    innerObject.innerHTML = '';
    displayObject.style.display = 'none';
  }
}

function jsonToHTML(data, title, field) {
  var html = `
    <div class='level'>
      <div class='level-left'>
        <div class='level-item'>
          ${title}
        </div>
      </div>
    </div>
  `;

  data.map( element => {
    var link = '';

    switch(title) {
      case "WORKSPACES":
        link = linkToWorkspace(element.id, element.name);
        break;
      case "PROJECTS":
        link = linkToProject(element.id, element.workspace_id, element.name);
        break;
      case "TASKS":
        link = linkToTask(element.id, element.project_id, element.title);
        break;
    }

    html += `
      <div class="level is-small">
        <div class="level-left">
          <div class="level-item">
            ${ link }
          </div>
        </div>
      </div>`
  });

  return html;
}

linkToWorkspace = (id, text) => {
  return `<a href="${Routes.account_workspace_path(id)}">${text}</a>`;
}

linkToProject = (id, workspaceId, text) => {
  return `<a href="${Routes.account_workspace_project_path(workspaceId, id)}">${text}</a>`;
}

linkToTask = (id, projectId, text) => {
  return `<a href="${Routes.account_project_task_path(projectId, id)}">${text}</a>`;
}
