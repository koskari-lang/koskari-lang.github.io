# This library is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 3 of the License, or
# (at your option) any later version.
#
# This library is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this library; if not, see <http://www.gnu.org/licenses/>.


"""
conf

Sphinx configuration for the koskari.org site. The landing page is a
template rendered through html_additional_pages; Markdown sources
render through the koskari theme layout. Files under _extra are copied
verbatim to the site root, dotfiles included.

:author: Christopher O'Brien <obriencj@gmail.com>
:license: GNU General Public License v3
"""


project = 'Koskari'
author = "Christopher O'Brien"
copyright = f"2025-2026, {author}"

extensions = [
    'myst_parser',
]

source_suffix = {
    '.md': 'markdown',
}

# The landing page is a template, not a document. The 404 page is the
# only Markdown source, so it stands as the root document.
root_doc = '404'

exclude_patterns = [
    '_build', '_extra', 'Thumbs.db', '.DS_Store',
]

templates_path = ['_templates']

html_theme = 'koskari'
html_theme_path = ['_themes']

html_additional_pages = {
    'index': 'index.html',
}

html_static_path = ['_static']
html_extra_path = ['_extra']

html_baseurl = 'https://koskari.org/'

html_use_index = False
html_domain_indices = False
html_copy_source = False
html_show_sourcelink = False


def disable_search(app):
    """
    Turn off the search page and search index for the HTML builder
    """

    if hasattr(app.builder, 'search'):
        app.builder.search = False


def setup(app):
    app.connect('builder-inited', disable_search)


# The end.
