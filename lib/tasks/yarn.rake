# frozen_string_literal: true

Rake::Task['assets:precompile'].enhance ['yarn:install']
