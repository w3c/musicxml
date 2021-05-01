# MusicXML documentation generator

The MusicXML specification is created with the same documentation
generator used for MNX. To avoid duplication of code, all that
is contained in this directory is the MusicXML specific data.

As with MNX, it's a database-driven web app, using Django. We 
manage the MusicXML docs within that app, using the Django admin
to make things easily editable and previewable via a local web
server. Then, when things look good, we "freeze" the current
state of the database into a serialized JSON file, and we
generate a static HTML site via a script.

If you're interested in contributing, here's how to get it
working:

## Assembling the files

To avoid code duplication between repositories, there are 
currently some extra steps to put all the files in the right
places.

1. Fetch the current version of the W3C mnx repository.

2. Copy *ONLY* the following files and directories from the 
docgenerator directory of the mnx repository into the
docgenerator directory of the musicxml repository (the
directory containing this README file):

- The docgenerator folder
- The manage.py file
- The requirements.txt file
- The spec folder

3. Copy the homepage.html file from this folder into the 
spec/templates folder, overwriting the homepage.html file from
the mnx repository.

## Setup your environment

Note: All of these commands should be run from within the
same directory that contains this README file.

1. Install Python 3.7 or higher.

2. (Optional but recommended) Create a Python virtual environment.
Here's how to create one called `musicxmldocs` in your home directory:

```
python3 -m venv ~/musicxmldocs
```

3. Activate the virtual environment:

```
source ~/musicxmldocs/bin/activate
```

4. Install the required Python modules:

```
pip install -r requirements.txt
```

5. Initialize a local database:

```
python manage.py migrate
```

This creates a SQLite file called `db.sqlite3` in the current
directory.

6. Import the MusicXML spec data into your local database:

```
python manage.py loaddb musicmldata.json
```

## Running the site locally

Once that's all set up, you can run a local web server to
inspect and edit the documentation:

1. Run the Django web server:

```
python manage.py runserver
```

2. Go to http://127.0.0.1:8000/ in your web browser.
You'll be able to browse the MusicXML documentation.

## Editing the documentation

With the local web server running, you can use the
Django admin to edit the documentation:

1. Go to http://127.0.0.1:8000/admin/ in your web
browser.

2. Enter `admin` for both the username and password.

3. This is a standard Django admin installation. You
can view and edit the various data -- MusicXML elements,
examples, static pages, etc. As soon as you make a change
and save it within this admin, the change will be
reflected on any of the documentation pages, so you
can immediately view your work.

## Committing your documentation changes

We don't actually check in the SQLite database to Git.
Instead, we serialize the data in two ways:

1. The raw data itself lives in a JSON file called
`musicxmldoc.json` within this directory.

2. The generated HTML of the whole website lives
in the top-level `docs` of this Git repo.

We use two separate commands to generate this.

### Serializing the database

To serialize the database, hence creating an updated
`musicxmldoc.json`, do the following:

```
python manage.py freezedb musicxmldoc.json
```

(The `musicxmldoc.json` in this command lets you 
specify the filename.)

### Generating a static HTML version of the docs

To export a static version of the docs -- as opposed
to the dynamic one you can browse via the local web
server -- do the following:

```
python manage.py makesite ../docs/
```

This will create static HTML files for each page of the
docs, using relative links appropriately. It also includes
the media files, such as CSS and example images.

The `../docs/` in this command lets you specify the
output location of the static site. For example, this
command will generate them at `/Users/MusicXML/Desktop`:

```
python manage.py makesite /Users/MusicXML/Desktop
```

The easiest way to view the static site is to find the
top-level `index.html` file in the directory you
specified in the `makesite` command, and open that
`index.html` file in your web browser.

A nicer way (avoiding the problem of web browsers
displaying directory indexes) is to use Python's built-in
web server, via this command:

```
python -m http.server --directory /path/to/docs/
```

This will make the docs available at `http://127.0.0.1:8000/`
on your local machine.

## Updating your local database with the latest changes

Over time, we update the `musicxmldoc.json` file with the
latest and greatest documentation. To update your local
DB, use this command:

```
python manage.py loaddb musicxmldoc.json
```

WARNING: This will delete any local changes you've made
to your database.

## Suggested workflow for doc contributions

If you'd like to make an addition or correction to the docs,
here's our suggested workflow:

1. Make sure your Git checkout is using the latest commit
from the `master` branch.

2. Update your local database with the latest `musicxmldoc.json`
(see above).

3. Run the local web server and make (and preview) your changes.

4. When you're ready to share, use `freezedb` to generate
a new `musicxmldoc.json` file.

5. Create a pull request with that new `musicxmldoc.json` file.
Due to pretty-printing of the JSON, it should be reasonably
comprehensible to view a `diff` between your file and the
master file.

At the moment, don't worry about regenerating the static HTML
in your pull request. This keeps the pull requests focused
on the core changes, as opposed to generated "spam." The MusicXML
maintainers can generate the HTML updates themselves for now.
(We might change this policy in the future, once we get a feel
for how this system works over time.)
