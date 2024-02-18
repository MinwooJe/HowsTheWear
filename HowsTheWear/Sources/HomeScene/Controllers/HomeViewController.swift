//
//  HomeViewController.swift
//  HowsTheWear
//
//  Created by Rafael on 1/3/24.
//

import UIKit

import SnapKit
import Then

final class HomeViewController: UIViewController {
    
    var items: [TodayItem] = TodayItem.items
    
    private let refreshControl = UIRefreshControl().then {
        $0.tintColor = #colorLiteral(red: 0.4442995787, green: 0.6070379615, blue: 0.9031649232, alpha: 1)
    }
    private let tableView = UITableView(frame: .zero, style: .plain)
    private let backgroundImageView = UIImageView()
    private let backgroundView = UIView().then {
        $0.backgroundColor = .white
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 30
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
}

// MARK: - UITableViewDataSource

extension HomeViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: CurrentWeatherCell.reuseIdentifier, for: indexPath
            ) as? CurrentWeatherCell else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            cell.backgroundColor = .clear
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: TodayWeatherCell.reuseIdentifier, for: indexPath
            ) as? TodayWeatherCell else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            cell.backgroundColor = .clear
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: TodayItemCell.reuseIdentifier,
                for: indexPath
            ) as? TodayItemCell else {
                return UITableViewCell()
            }
            cell.backgroundColor = .clear
            cell.selectionStyle = .none
            return cell
        case 3:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: HourlyWeatherCell.reuseIdentifier, for: indexPath
            ) as? HourlyWeatherCell else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            cell.backgroundColor = .clear
            return cell
        case 4:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: DailyWeatherCell.reuseIdentifier, for: indexPath
            ) as? DailyWeatherCell else {
                return UITableViewCell()
            }
            cell.selectionStyle = .none
            cell.backgroundColor = .clear
            return cell
        default:
            return UITableViewCell()
        }
    }
    
}

// MARK: - UITableViewDelegate

extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return UITableView.automaticDimension
        case 1:
            return UITableView.automaticDimension
        case 2:
            return TodayItemCell.cellHeight
        case 3:
            return HourlyWeatherCell.cellHeight
        case 4:
            return DailyWeatherCell.cellHeight
        default:
            return UITableView.automaticDimension
        }
    }
    
}

// MARK: - UI Configuration

private extension HomeViewController {
    
    func configureUI() {
        setupNavigationBarUI()
        setupTableView()
    }
    
    func setupNavigationBarUI() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .clear
        appearance.shadowColor = nil
        navigationController?.navigationBar.standardAppearance = appearance
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        tableView.addSubview(refreshControl)
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        backgroundImageView.image = UIImage(named: "background-image")
        backgroundImageView.contentMode = .scaleAspectFill
        
        tableView.separatorStyle = .none
        tableView.backgroundView = backgroundImageView
        tableView.dataSource = self
        tableView.delegate = self
        
        registerTableViews()
    }
    
    func registerTableViews() {
        tableView.register(CurrentWeatherCell.self, forCellReuseIdentifier: CurrentWeatherCell.reuseIdentifier)
        tableView.register(TodayWeatherCell.self, forCellReuseIdentifier: TodayWeatherCell.reuseIdentifier)
        tableView.register(TodayItemCell.self, forCellReuseIdentifier: TodayItemCell.reuseIdentifier)
        tableView.register(HourlyWeatherCell.self, forCellReuseIdentifier: HourlyWeatherCell.reuseIdentifier)
        tableView.register(DailyWeatherCell.self, forCellReuseIdentifier: DailyWeatherCell.reuseIdentifier)
    }
    
    @objc func refreshData() {
        LocationManager.shared.getCurrentLocation { [weak self] location in
            WeatherManager.shared.getWeather(for: location) {
                DispatchQueue.main.async {
                    self?.updateCurrentWeatherCell()
                    self?.tableView.reloadData()
                    self?.refreshControl.endRefreshing()
                }
            }
        }
    }

    func updateCurrentWeatherCell() {
        guard let currentWeather = WeatherManager.shared.currentWeather,
              let location = LocationManager.shared.location else {
            return
        }
        
        if let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? CurrentWeatherCell {
            cell.updateWeather(currentWeather: currentWeather, location: location)
        }
    }
    
}
