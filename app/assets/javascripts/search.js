document.addEventListener('DOMContentLoaded', e => {
  const workspace_url = 'http://localhost:3000/account/workspaces/search.json';
  const projects_url = 'http://localhost:3000/account/projects/search.json';
  const tasks_url = 'http://localhost:3000/account/tasks/search.json';

  let search = document.getElementById('search');
  let searchResults = document.getElementById('search-results');

  let workspaces = document.getElementById('workspaces');
  let projects = document.getElementById('projects');
  let tasks = document.getElementById('tasks');

  let workspacesBlock = document.getElementById('workspaces-block');
  let projectsBlock = document.getElementById('projects-block');
  let tasksBlock = document.getElementById('tasks-block');

  let timer;

  search.addEventListener('keyup', e => {

    clearTimeout(timer)
    timer = setTimeout(() => {
      if (e.target.value) {
        getData(workspace_url,
          workspaces,
          'workspaces',
          'WORKSPACES',
          e.target.value,
          workspacesBlock
        );

        getData(projects_url,
          projects,
          'projects',
          'PROJECTS',
          e.target.value,
          projectsBlock
        );

        getData(tasks_url,
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

});

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
  html = `
    <div class='level'>
      <div class='level-left'>
        <div class='level-item'>
          ${title}
        </div>
      </div>
    </div>
  `;

  data.map( element => {
    let link = '';

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
  return `<a href="http://localhost:3000/account/workspaces/${id}">${text}</a>`;
}

linkToProject = (id, workspaceId, text) => {
  return `<a href="http://localhost:3000/account/workspaces/${workspaceId}/projects/${id}">${text}</a>`;
}

linkToTask = (id, projectId, text) => {
  return `
    <a href="http://localhost:3000/account/projects/${projectId}/tasks/${id}">${text}</a>`;
}
