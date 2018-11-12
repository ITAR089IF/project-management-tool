function global_search() {
  search.addEventListener('keyup', e => {

    var search = document.getElementById('search');
    var searchResults = document.getElementById('search-results');

    var workspaces = document.getElementById('workspaces');
    var projects = document.getElementById('projects');
    var tasks = document.getElementById('tasks');

    var workspacesBlock = document.getElementById('workspaces-block');
    var projectsBlock = document.getElementById('projects-block');
    var tasksBlock = document.getElementById('tasks-block');

    var timer;

    clearTimeout(timer)
    timer = setTimeout(() => {
      if (e.target.value) {
        getData(Routes.account_workspaces_search_path({ format: "json" }),
          workspaces,
          'workspaces',
          'WORKSPACES',
          e.target.value,
          workspacesBlock
        );

        getData(Routes.account_projects_search_path({ format: "json" }),
          projects,
          'projects',
          'PROJECTS',
          e.target.value,
          projectsBlock
        );

        getData(Routes.account_tasks_search_path({ format: "json" }),
          tasks,
          'tasks',
          'TASKS',
          e.target.value,
          tasksBlock
        )

      searchResults.style.display = 'block';
      } else {
        workspaces.innerHTML = '';
        projects.innerHTML ='';
        tasks.innerHTML = '';

        searchResults.style.display = 'none';
        workspacesBlock.style.display = 'none';
        projectsBlock.style.display = 'none';
        tasksBlock.style.display = 'none';
      }
    }, 300);
  })
}


function getData(url, innerObject, objectName, title, search, displayObject) {
  if (search) {
    fetch(`${url}?search=${search}`)
    .then(responce => { return responce.json() })
    .then(responce => {
      if (responce[objectName].length > 0) {
        displayObject.style.display = 'block';
        innerObject.innerHTML = jsonToHTML(responce[objectName], title);
      } else {
        innerObject.innerHTML = '';
        displayObject.style.display = 'none';
      }
    })
    .catch(error => { console.log(error) });
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
