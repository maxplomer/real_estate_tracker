#Concept:
This site is inspired by www.viewthespace.com and other real estate apps, and it functions as site to display available listings, and also to track visitors and do financial analyses for the logged in user.  The financial analyses are quite complex and are presented in a logical manner using css styled diagrams.

#Technologies:
The site is a Ruby on Rails app with a PostgreSQL database. Pictures for new listings can be saved to an Amazon S3 bucket via the Paperclip gem.  Financial calculation pages feature HTML sliders to adjust values and are live updated using jQuery and AJAX calls.  Ruby and JavaScript helper functions are used to display numbers with commas and preceeded with a $ or followed by a % where necessary.

#Todos:
- Add other finacial calculations like "What is my mortgage payment?"
- Restyle listing page so can function as stand alone website for the property
