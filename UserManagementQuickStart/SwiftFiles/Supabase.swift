//
//  Supabase.swift
//  UserManagementQuickStart
//
//  Created by Zaid Syed on 8/4/24.
//

import Foundation
import Supabase

let supabase = SupabaseClient(
  supabaseURL: URL(string: "https://enxbwtpvtqyisppcdjqt.supabase.co")!,
  supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImVueGJ3dHB2dHF5aXNwcGNkanF0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjI4MDE0MjAsImV4cCI6MjAzODM3NzQyMH0.hvq90cL3y_E80lnW-XJHxw5QjsmJXSsBaPkAJe8jF3c"
)
